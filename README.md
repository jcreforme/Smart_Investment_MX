# 📊 Smart Investment MX
<img width="283" height="170" alt="image" src="https://github.com/user-attachments/assets/0f1c2762-a941-496f-b0ff-6f69a088226c" />

An app for monitoring investment portfolios in Mexico, including assets such as FIBRAs, ETFs, and other dividend-paying instruments. It generates alerts via Telegram and allows you to simulate financial scenarios using PER and dividend yield.

<img width="292" height="266" alt="image" src="https://github.com/user-attachments/assets/9eeb1dfb-518a-4c56-80aa-3455f4f4589b" />

<img width="297" height="245" alt="image" src="https://github.com/user-attachments/assets/f555010a-99c8-4271-b6a6-71d55f902026" />

<img width="260" height="242" alt="image" src="https://github.com/user-attachments/assets/8a070579-8578-4c45-bb3b-d691a4e79c29" />


---

## 🧱 Tecnologías

- **Backend:** Ruby on Rails (API-only) DONE!!!
- **Frontend:** ReactJS + Vite (NOT YET)
- **Alertas:** Telegram Bot API (NOT YET)
- **Background Jobs:** Sidekiq (NOT YET)
- **Base de datos:** PostgreSQL (NOT YET)

---

## 🌟 Features

The application provides the following functionalities:

1. **View Portfolio**: Display current investment positions.
2. **Simulate Dividends**: Estimate potential dividend income.
3. **Set Price Alerts**: Create alerts for specific stock prices.
4. **Simulate Rebalance**: Analyze portfolio rebalancing scenarios.
5. **Simulate Growth with Dividends**: Project portfolio growth over time with reinvested dividends.
6. **Check Saved Alerts**: View all saved price alerts.
7. **Delete Alert by Ticker**: Remove a specific price alert by its ticker.
8. **Edit Alert Price**: Update the target price of an existing alert.
9. **Exit**: Close the application.

---

## 🛠 Features

### Edit Alert Price

The `edit_alert_price` method allows users to update the target price of an existing alert. Here's how it works:

1. **Search Alerts**: The user provides criteria (e.g., Ticker) to search for matching alerts.
2. **Display Matches**: All matching alerts are displayed with their details (Ticker, Target Price, Status).
3. **Select Alert**: The user selects the alert they want to edit by entering its corresponding number.
4. **Update Target Price**: The user enters a new target price for the selected alert.
5. **Validation**: The method ensures the input is valid (e.g., within range, positive price).
6. **Save Changes**: The updated alert is saved back to the storage.

### Example Usage

#### Input:
```plaintext
Enter the criteria to search alerts (e.g., Ticker): AAPL
Matching Alerts:
1. Ticker: AAPL, Target Price: 200, Status: Active
Enter the number of the alert you want to edit (1-1): 1
Enter the new target price for AAPL: 250
```

#### Ouput:
```plaintext
✅ Target price for AAPL has been updated to 250.
```

---

## 🛠 Features

### Save Alerts

The `save_alerts` method is responsible for persisting all alerts to a storage file. Here's how it works:

1. **Purpose**: Ensures that all alerts are saved to a file for future retrieval.
2. **File Format**: Alerts are stored in a CSV file format for easy readability and compatibility.
3. **Overwrite Behavior**: Each time the method is called, it overwrites the existing file with the latest alert data.
4. **Data Saved**: Each alert includes the following details:
   - Ticker
   - Target Price
   - Status (e.g., Active, Inactive)

### Example Usage

#### Code Example:
```ruby
# Example of saving alerts
alerts = [
  { ticker: "AAPL", target_price: 150, status: "Active" },
  { ticker: "GOOGL", target_price: 2800, status: "Inactive" }
]
```

#### OUTPUT
```plaintext
Ticker,Target Price,Status
AAPL,150,Active
GOOGL,2800,Inactive
```


---

## 🛠 Features

### Delete Alert by Ticker

The `delete_alert_by_ticker` method allows users to remove an alert associated with a specific ticker. Here's how it works:

1. **Search Alerts**: Users provide the ticker symbol of the alert they want to delete.
2. **Display Matches**: All alerts matching the provided ticker are displayed.
3. **Confirm Deletion**: Users confirm whether they want to delete the alert.
4. **Remove Alert**: The selected alert is removed from the storage.
5. **Save Changes**: The updated list of alerts is saved back to the storage file.

### Example Usage

#### Input:
```plaintext
Enter the ticker of the alert you want to delete: AAPL
Matching Alerts:
1. Ticker: AAPL, Target Price: 200, Status: Active
Are you sure you want to delete this alert? (yes/no): yes
```

#### Output
```plaintext
✅ The alert for AAPL has been successfully deleted.
```
