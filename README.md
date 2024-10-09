# Tikeetron Flutter Mobile App

Tikeetron is an AI-first event marketplace mobile app powered by the TRON blockchain. This Flutter application allows users to manage TRON-based wallets, purchase NFT-based event tickets, and securely transfer or validate tickets using QR codes.

## Features
- **Wallet Creation/Import**: Create or import TRON wallets using seed phrases or QR codes.
- **AI-First Interface**: Browse events, manage tickets, and get personalized recommendations via AI chat.
- **Secure Blockchain Integration**: Leverage TRON blockchain for secure ticketing operations.
- **Ticket Transfer and Purchase**: Buy and transfer NFT-based tickets seamlessly.
- **QR Code Validation**: Validate tickets at events using QR codes.

## Dependencies

The app relies on several blockchain-related dependencies to integrate with the TRON blockchain and handle cryptographic operations. Below is a list of these key dependencies:

### 1. **tron**  
This package integrates TRON blockchain functionality, enabling interaction with TRON wallets, transactions, and smart contracts.

### 2. **web3dart**  
`web3dart` is used to interact with Ethereum-like blockchain networks. In our app, it helps facilitate wallet and contract interactions with TRON by adapting for TRON’s architecture.

### 3. **bdk_flutter**  
This package is a Flutter implementation of the Bitcoin Development Kit (BDK). It handles on-chain Bitcoin functionalities, but we adapt it in parts of the app for secure wallet management and cryptographic operations.

### 4. **bip32**  
`bip32` is a standard for hierarchical deterministic (HD) wallets, ensuring secure key generation for TRON wallets.

### 5. **bip39**  
`bip39` generates mnemonic phrases for TRON wallet creation, following the standard to provide users with human-readable seed phrases for wallet recovery.

### 6. **bip32_bip44**  
`bip32_bip44` extends support to the BIP44 standard, used to generate multiple cryptocurrency wallets (like TRON) from a single seed phrase.

### 7. **on_chain**  
This package handles on-chain operations such as broadcasting transactions and interacting with smart contracts deployed on the TRON network.

## Installation

To run the Tikeetron mobile app locally, follow the steps below:

1. **Clone the Repository**  
   ```bash
   git clone https://github.com/TikeeTron/TikeeTron_mobile.git
   cd tikeetron-mobile
   ```

2. **Install Dependencies**  
   Install the Flutter dependencies by running:
   ```bash
   flutter pub get
   ```

3. **Run the App**  
   You can now run the app on your preferred device or emulator:
   ```bash
   flutter run
   ```

## Wallet Setup

To create or import a wallet in the Tikeetron app:
- **Create Wallet**: The app will generate a new TRON wallet and provide you with a mnemonic phrase. Ensure you store this phrase securely.
- **Import Wallet**: Use an existing mnemonic phrase or scan a QR code to import your TRON wallet.

## Event Management and Ticketing

For event organizers, the Tikeetron app allows easy event management. You can create and list events, sell tickets, and validate them using QR codes, all while ensuring transaction security on the TRON blockchain.

## Smart Contracts

Tikeetron leverages TRON’s smart contracts to manage NFT-based tickets. Each ticket is represented as an ERC721 NFT, ensuring unique ownership and fraud protection.

## AI Integration

Tikeetron uses Llama3 AI with RAG (Retrieval-Augmented Generation) connected to a MongoDB vector database for personalized event recommendations and seamless ticket management.

## Learn More

For detailed documentation, visit our [White Paper](https://docs.tikeetron.cloud/).

## License

This project is licensed under the MIT License. See the LICENSE file for more information.



