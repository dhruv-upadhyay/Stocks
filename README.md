# Crypto Coin List Application

This repository contains an iOS application built using the **MVVM architecture** to showcase a list of crypto coins. The app is designed to be scalable, maintainable, and production-ready, adhering to Clean Architecture principles. The user interface (UI) is implemented programmatically to ensure flexibility and robustness.

---

## Features

1. **Crypto Coin List Display**
   - Shows a list of all available crypto coins.
   - Each coin card displays the following details:
     - **Name**: Full name of the crypto coin.
     - **Symbol**: Symbol representation (e.g., BTC for Bitcoin).
     - **Type**: Type of the coin.
   - Disabled appearance for inactive coins.

2. **Filtering Options**
   - Filter by **active coins** (`is_active`).
   - Filter by **coin type** (`type`).
   - Filter by **new coins** (`is_new`).
   - Support for **multiple filters** simultaneously.

3. **Search Functionality**
   - Search for coins by their **name** or **symbol**.

4. **API Integration**
   - Data fetched from the endpoint:
     `https://37656be98b8f42ae8348e4da3ee3193f.api.mockbin.io/`.

5. **Clean UI Implementation**
   - Programmatic layout to ensure clean UI without constraint warnings.
   - Adaptive UI for a seamless user experience.
