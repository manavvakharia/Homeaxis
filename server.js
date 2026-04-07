/**
 * HomeAxis Broker API Server
 * Connects broker dashboard to MySQL (people_db) or file database (customers-db.json)
 * Customer login remains on localStorage - not connected to DB
 */

const express = require("express");
const mysql = require("mysql2/promise");
const cors = require("cors");
const path = require("path");
const fs = require("fs");

const app = express();
const PORT = process.env.PORT || 3000;
const FILE_DB = path.join(__dirname, "customers-db.json");

// Database config - update for your MySQL setup
const dbConfig = {
  host: process.env.DB_HOST || "localhost",
  user: process.env.DB_USER || "root",
  password: process.env.DB_PASSWORD || "",
  database: process.env.DB_NAME || "people_db",
};

app.use(cors());
app.use(express.json({ limit: "10mb" }));
app.use(express.static(__dirname));

let pool;
let fileDb = { customers: [] };

function loadFileDb() {
  try {
    if (fs.existsSync(FILE_DB)) {
      fileDb = JSON.parse(fs.readFileSync(FILE_DB, "utf8"));
      if (!Array.isArray(fileDb.customers)) fileDb.customers = [];
      console.log("✅ File database loaded:", fileDb.customers.length, "customers");
    }
  } catch (e) {
    console.warn("File DB load failed:", e.message);
  }
  return fileDb.customers || [];
}

function saveFileDb(customers) {
  fs.writeFileSync(FILE_DB, JSON.stringify({ customers }, null, 2), "utf8");
  fileDb = { customers };
}

async function initDb() {
  try {
    pool = mysql.createPool(dbConfig);
    await pool.query("SELECT 1");
    console.log("✅ MySQL connected (people_db)");
  } catch (err) {
    console.warn("⚠️ MySQL not available:", err.message);
    pool = null;
    loadFileDb();
  }
}

/**
 * GET /api/customers
 * Fetches potential customers from MySQL or file database
 * Query params: ageMin, ageMax, gender, professions (comma-separated), maritalStatus
 */
app.get("/api/customers", async (req, res) => {
  const { ageMin, ageMax, gender, professions, maritalStatus } = req.query;

  const filter = (list) => {
    return list.filter((c) => {
      if (ageMin && (c.age == null || c.age < parseInt(ageMin, 10))) return false;
      if (ageMax && (c.age == null || c.age > parseInt(ageMax, 10))) return false;
      if (gender && gender !== "Any" && c.gender !== gender) return false;
      if (maritalStatus && c.maritalStatus !== maritalStatus) return false;
      if (professions) {
        const profs = professions.split(",").map((p) => p.trim()).filter(Boolean);
        if (profs.length && !profs.includes(c.profession)) return false;
      }
      return true;
    });
  };

  if (pool) {
    try {
    let sql = `
      SELECT p.id, p.name, p.age, p.gender, p.profession, p.marital_status AS maritalStatus,
             p.email, p.contact_no,
             cp.location_preference AS location, cp.property_type AS type, cp.bhk,
             cp.budget_lakhs * 100000 AS budget
      FROM people p
      LEFT JOIN customer_preferences cp ON p.id = cp.customer_id
      WHERE 1=1
    `;
    const params = [];

    if (ageMin) {
      sql += " AND p.age >= ?";
      params.push(parseInt(ageMin, 10));
    }
    if (ageMax) {
      sql += " AND p.age <= ?";
      params.push(parseInt(ageMax, 10));
    }
    if (gender && gender !== "Any") {
      sql += " AND p.gender = ?";
      params.push(gender);
    }
    if (maritalStatus) {
      sql += " AND p.marital_status = ?";
      params.push(maritalStatus);
    }
    if (professions && professions.length) {
      const profs = professions.split(",").map((p) => p.trim()).filter(Boolean);
      if (profs.length) {
        sql += " AND p.profession IN (?)";
        params.push(profs);
      }
    }

    const [rows] = await pool.query(sql, params);

    const customers = rows.map((r) => ({
      email: r.email,
      age: r.age,
      gender: r.gender,
      profession: r.profession,
      maritalStatus: r.maritalStatus || r.marital_status,
      contact_no: r.contact_no,
      preference: r.location
        ? {
            location: r.location,
            type: r.type,
            bhk: r.bhk,
            budget: r.budget,
          }
        : null,
    }));

    return res.json({ customers });
  } catch (err) {
    console.error("API /api/customers error:", err);
    return res.status(500).json({ error: err.message });
  }
  }

  /* Fallback: file database (customers-db.json) */
  try {
    const list = loadFileDb();
    const customers = filter(list).map((c) => ({
      email: c.email,
      age: c.age,
      gender: c.gender,
      profession: c.profession,
      maritalStatus: c.maritalStatus,
      contact_no: c.contact_no,
      preference: c.preference || null,
    }));
    return res.json({ customers, source: "file" });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
});

/**
 * POST /api/customers/upload
 * Upload a customers database JSON file
 * Body: { customers: [...] } or { customers: [...] } wrapped
 */
app.post("/api/customers/upload", (req, res) => {
  try {
    const body = req.body;
    let customers = Array.isArray(body) ? body : (body.customers || []);
    if (!Array.isArray(customers)) {
      return res.status(400).json({ error: "Invalid format. Expected { customers: [...] }" });
    }
    saveFileDb(customers);
    return res.json({ success: true, count: customers.length });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
});

/**
 * GET /api/customers/download
 * Download the current file database as JSON
 */
app.get("/api/customers/download", (req, res) => {
  try {
    const data = fs.readFileSync(FILE_DB, "utf8");
    res.setHeader("Content-Type", "application/json");
    res.setHeader("Content-Disposition", 'attachment; filename="customers-db.json"');
    res.send(data);
  } catch (e) {
    res.status(404).json({ error: "File database not found" });
  }
});

/**
 * Health check
 */
app.get("/api/health", async (req, res) => {
  if (!pool) {
    return res.json({ status: "no-db", database: false });
  }
  try {
    await pool.query("SELECT 1");
    res.json({ status: "ok", database: true });
  } catch (e) {
    res.json({ status: "error", database: false });
  }
});

initDb().then(() => {
  app.listen(PORT, () => {
    console.log(`HomeAxis server running at http://localhost:${PORT}`);
    if (!pool) {
      console.log("Broker uses file database (customers-db.json). Upload via broker dashboard.");
    }
  });
});
