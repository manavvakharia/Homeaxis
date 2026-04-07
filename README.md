# HomeAxis Real Estate Platform

A comprehensive real estate platform with three user profiles: Broker, Builder, and Customer.

## Getting Started

### Opening the Website

1. **Option 1 (Recommended)**: Open `dashboard.html` in your browser
   - This is the main entry point where users choose their profile

2. **Option 2**: Open `index.html` in your browser
   - Click the "Dashboard" button in the navigation bar
   - Or browse properties directly

3. **Option 3**: Use `redirect.html` for automatic redirect to dashboard

## Features

### 🔄 Cross-Profile Data Sharing

All changes made in any profile are immediately visible across all dashboards:

- **Builder adds property** → Shows in:
  - Main property listings (index.html)
  - Customer dashboard
  - Broker dashboard

- **Customer sets preferences** → Shows in:
  - Broker dashboard (to match customers)
  - Builder dashboard (to understand demand)

- **Broker adds requirements** → Shows in:
  - Customer dashboard (to see what brokers need)
  - Builder dashboard (to understand market)

### User Profiles

#### 🏢 Broker
- Login/Signup with OTP verification
- Add customer requirements (age, gender, profession)
- Set guarantee flat options
- View customer preferences
- View builder properties

#### 🏗️ Builder
- Login/Signup
- Add property listings with website URLs
- View customer preferences
- View broker requirements

#### 👤 Customer
- Login/Signup
- Set property preferences (location, area, budget, BHK)
- View available properties from builders
- View broker requirements

## Broker Database Connection

The **Broker dashboard** fetches Potential Customers from a MySQL database (customer login stays on localStorage).

### Setup

1. **Install MySQL** and create the database:
   ```bash
   mysql -u root -p < people_db.sql
   ```

2. **Install Node.js dependencies** and start the server:
   ```bash
   npm install
   npm start
   ```

3. Open `http://localhost:3000/broker-dashboard.html` (after broker login).

4. Configure DB credentials via environment variables (optional):
   - `DB_HOST`, `DB_USER`, `DB_PASSWORD`, `DB_NAME` (default: `people_db`)

If the database is unavailable, the broker falls back to localStorage (seeded customers).

## Data Storage

Customer login and most data use browser localStorage:
- `brokers` - Broker accounts
- `builders` - Builder accounts
- `customers` - Customer accounts
- `brokerRequirements` - Customer requirements
- `builderProperties` - Property listings
- `customerPreferences` - Property preferences

## Real-Time Updates

The platform uses:
- localStorage events for cross-tab updates
- Custom events for same-tab updates
- Automatic page refresh on data changes

## File Structure

```
real-estate-frontend/
├── dashboard.html          # Main dashboard (entry point)
├── index.html             # Property listings page
├── broker-login.html      # Broker authentication
├── broker-dashboard.html  # Broker management
├── builder-login.html     # Builder authentication
├── builder-dashboard.html # Builder property management
├── customer-login.html    # Customer authentication
├── customer-dashboard.html # Customer preferences
└── images/                # Property images directory
```

## Usage Flow

1. Open `dashboard.html`
2. Choose profile (Broker/Builder/Customer)
3. Sign up or log in
4. Make changes in your dashboard
5. See changes reflected in all other dashboards automatically

## Notes

- OTP is displayed in console/alert for testing
- Email confirmation is simulated
- All data persists in browser localStorage
- Responsive design for all devices
- Dark theme throughout
