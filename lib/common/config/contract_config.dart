class ContractConfig {
  static const List<Map<String, Object>> abi = [
    {"type": "constructor", "inputs": [], "stateMutability": "nonpayable"},
    {
      "type": "function",
      "name": "approve",
      "inputs": [
        {"name": "to", "type": "address", "internalType": "address"},
        {"name": "tokenId", "type": "uint256", "internalType": "uint256"}
      ],
      "outputs": [],
      "stateMutability": "nonpayable"
    },
    {
      "type": "function",
      "name": "balanceOf",
      "inputs": [
        {"name": "owner", "type": "address", "internalType": "address"}
      ],
      "outputs": [
        {"name": "", "type": "uint256", "internalType": "uint256"}
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "buyTicket",
      "inputs": [
        {"name": "eventId", "type": "uint256", "internalType": "uint256"},
        {"name": "metadata", "type": "string", "internalType": "string"},
        {"name": "ticketType", "type": "string", "internalType": "string"}
      ],
      "outputs": [],
      "stateMutability": "payable"
    },
    {
      "type": "function",
      "name": "createEvent",
      "inputs": [
        {"name": "name", "type": "string", "internalType": "string"},
        {"name": "metadata", "type": "string", "internalType": "string"},
        {"name": "startDate", "type": "uint256", "internalType": "uint256"},
        {"name": "endDate", "type": "uint256", "internalType": "uint256"},
        {
          "name": "ticketInfos",
          "type": "tuple[]",
          "internalType": "struct TicketInfo[]",
          "components": [
            {"name": "ticketType", "type": "string", "internalType": "string"},
            {"name": "ticketPrice", "type": "uint256", "internalType": "uint256"},
            {"name": "ticketSupply", "type": "uint256", "internalType": "uint256"},
            {"name": "ticketStartDate", "type": "uint256", "internalType": "uint256"},
            {"name": "ticketEndDate", "type": "uint256", "internalType": "uint256"}
          ]
        }
      ],
      "outputs": [],
      "stateMutability": "nonpayable"
    },
    {
      "type": "function",
      "name": "events",
      "inputs": [
        {"name": "eventId", "type": "uint256", "internalType": "uint256"}
      ],
      "outputs": [
        {"name": "name", "type": "string", "internalType": "string"},
        {"name": "metadata", "type": "string", "internalType": "string"},
        {"name": "organizer", "type": "address", "internalType": "address payable"},
        {"name": "startDate", "type": "uint256", "internalType": "uint256"},
        {"name": "endDate", "type": "uint256", "internalType": "uint256"}
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "getApproved",
      "inputs": [
        {"name": "tokenId", "type": "uint256", "internalType": "uint256"}
      ],
      "outputs": [
        {"name": "", "type": "address", "internalType": "address"}
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "getAvailableTicketsByType",
      "inputs": [
        {"name": "eventId", "type": "uint256", "internalType": "uint256"},
        {"name": "ticketType", "type": "string", "internalType": "string"}
      ],
      "outputs": [
        {"name": "", "type": "uint256", "internalType": "uint256"}
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "getEvent",
      "inputs": [
        {"name": "eventId", "type": "uint256", "internalType": "uint256"}
      ],
      "outputs": [
        {
          "name": "",
          "type": "tuple",
          "internalType": "struct EventInfo",
          "components": [
            {"name": "name", "type": "string", "internalType": "string"},
            {"name": "metadata", "type": "string", "internalType": "string"},
            {"name": "organizer", "type": "address", "internalType": "address payable"},
            {"name": "startDate", "type": "uint256", "internalType": "uint256"},
            {"name": "endDate", "type": "uint256", "internalType": "uint256"}
          ]
        }
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "getEventId",
      "inputs": [
        {"name": "ticketId", "type": "uint256", "internalType": "uint256"}
      ],
      "outputs": [
        {"name": "", "type": "uint256", "internalType": "uint256"}
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "_ticketId",
      "inputs": [],
      "outputs": [
        {"name": "", "type": "uint256", "internalType": "uint256"}
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "isApprovedForAll",
      "inputs": [
        {"name": "owner", "type": "address", "internalType": "address"},
        {"name": "operator", "type": "address", "internalType": "address"}
      ],
      "outputs": [
        {"name": "", "type": "bool", "internalType": "bool"}
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "name",
      "inputs": [],
      "outputs": [
        {"name": "", "type": "string", "internalType": "string"}
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "owner",
      "inputs": [],
      "outputs": [
        {"name": "", "type": "address", "internalType": "address"}
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "ownerOf",
      "inputs": [
        {"name": "tokenId", "type": "uint256", "internalType": "uint256"}
      ],
      "outputs": [
        {"name": "", "type": "address", "internalType": "address"}
      ],
      "stateMutability": "view"
    },
    {"type": "function", "name": "renounceOwnership", "inputs": [], "outputs": [], "stateMutability": "nonpayable"},
    {
      "type": "function",
      "name": "safeTransferFrom",
      "inputs": [
        {"name": "from", "type": "address", "internalType": "address"},
        {"name": "to", "type": "address", "internalType": "address"},
        {"name": "tokenId", "type": "uint256", "internalType": "uint256"}
      ],
      "outputs": [],
      "stateMutability": "nonpayable"
    },
    {
      "type": "function",
      "name": "safeTransferFrom",
      "inputs": [
        {"name": "from", "type": "address", "internalType": "address"},
        {"name": "to", "type": "address", "internalType": "address"},
        {"name": "tokenId", "type": "uint256", "internalType": "uint256"},
        {"name": "data", "type": "bytes", "internalType": "bytes"}
      ],
      "outputs": [],
      "stateMutability": "nonpayable"
    },
    {
      "type": "function",
      "name": "setApprovalForAll",
      "inputs": [
        {"name": "operator", "type": "address", "internalType": "address"},
        {"name": "approved", "type": "bool", "internalType": "bool"}
      ],
      "outputs": [],
      "stateMutability": "nonpayable"
    },
    {
      "type": "function",
      "name": "supportsInterface",
      "inputs": [
        {"name": "interfaceId", "type": "bytes4", "internalType": "bytes4"}
      ],
      "outputs": [
        {"name": "", "type": "bool", "internalType": "bool"}
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "symbol",
      "inputs": [],
      "outputs": [
        {"name": "", "type": "string", "internalType": "string"}
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "ticketInfo",
      "inputs": [
        {"name": "eventId", "type": "uint256", "internalType": "uint256"},
        {"name": "ticketType", "type": "string", "internalType": "string"}
      ],
      "outputs": [
        {"name": "ticketType", "type": "string", "internalType": "string"},
        {"name": "ticketPrice", "type": "uint256", "internalType": "uint256"},
        {"name": "ticketSupply", "type": "uint256", "internalType": "uint256"},
        {"name": "ticketStartDate", "type": "uint256", "internalType": "uint256"},
        {"name": "ticketEndDate", "type": "uint256", "internalType": "uint256"}
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "tickets",
      "inputs": [
        {"name": "ticketId", "type": "uint256", "internalType": "uint256"}
      ],
      "outputs": [
        {"name": "eventId", "type": "uint256", "internalType": "uint256"}
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "ticketsSold",
      "inputs": [
        {"name": "eventId", "type": "uint256", "internalType": "uint256"}
      ],
      "outputs": [
        {"name": "soldTickets", "type": "uint256", "internalType": "uint256"}
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "tokenURI",
      "inputs": [
        {"name": "tokenId", "type": "uint256", "internalType": "uint256"}
      ],
      "outputs": [
        {"name": "", "type": "string", "internalType": "string"}
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "transferFrom",
      "inputs": [
        {"name": "from", "type": "address", "internalType": "address"},
        {"name": "to", "type": "address", "internalType": "address"},
        {"name": "tokenId", "type": "uint256", "internalType": "uint256"}
      ],
      "outputs": [],
      "stateMutability": "nonpayable"
    },
    {
      "type": "function",
      "name": "transferOwnership",
      "inputs": [
        {"name": "newOwner", "type": "address", "internalType": "address"}
      ],
      "outputs": [],
      "stateMutability": "nonpayable"
    },
    {
      "type": "event",
      "name": "Approval",
      "inputs": [
        {"name": "owner", "type": "address", "indexed": true, "internalType": "address"},
        {"name": "approved", "type": "address", "indexed": true, "internalType": "address"},
        {"name": "tokenId", "type": "uint256", "indexed": true, "internalType": "uint256"}
      ],
      "anonymous": false
    },
    {
      "type": "event",
      "name": "ApprovalForAll",
      "inputs": [
        {"name": "owner", "type": "address", "indexed": true, "internalType": "address"},
        {"name": "operator", "type": "address", "indexed": true, "internalType": "address"},
        {"name": "approved", "type": "bool", "indexed": false, "internalType": "bool"}
      ],
      "anonymous": false
    },
    {
      "type": "event",
      "name": "BatchMetadataUpdate",
      "inputs": [
        {"name": "_fromTokenId", "type": "uint256", "indexed": false, "internalType": "uint256"},
        {"name": "_toTokenId", "type": "uint256", "indexed": false, "internalType": "uint256"}
      ],
      "anonymous": false
    },
    {
      "type": "event",
      "name": "EventCreated",
      "inputs": [
        {"name": "eventId", "type": "uint256", "indexed": true, "internalType": "uint256"},
        {"name": "name", "type": "string", "indexed": false, "internalType": "string"},
        {"name": "metadata", "type": "string", "indexed": false, "internalType": "string"},
        {"name": "organizer", "type": "address", "indexed": true, "internalType": "address"},
        {"name": "startDate", "type": "uint256", "indexed": false, "internalType": "uint256"},
        {"name": "endDate", "type": "uint256", "indexed": false, "internalType": "uint256"}
      ],
      "anonymous": false
    },
    {
      "type": "event",
      "name": "MetadataUpdate",
      "inputs": [
        {"name": "_tokenId", "type": "uint256", "indexed": false, "internalType": "uint256"}
      ],
      "anonymous": false
    },
    {
      "type": "event",
      "name": "OwnershipTransferred",
      "inputs": [
        {"name": "previousOwner", "type": "address", "indexed": true, "internalType": "address"},
        {"name": "newOwner", "type": "address", "indexed": true, "internalType": "address"}
      ],
      "anonymous": false
    },
    {
      "type": "event",
      "name": "TicketBought",
      "inputs": [
        {"name": "ticketId", "type": "uint256", "indexed": true, "internalType": "uint256"},
        {"name": "eventId", "type": "uint256", "indexed": true, "internalType": "uint256"},
        {"name": "ticketType", "type": "string", "indexed": false, "internalType": "string"},
        {"name": "buyer", "type": "address", "indexed": true, "internalType": "address"},
        {"name": "ticketPrice", "type": "uint256", "indexed": false, "internalType": "uint256"}
      ],
      "anonymous": false
    },
    {
      "type": "event",
      "name": "Transfer",
      "inputs": [
        {"name": "from", "type": "address", "indexed": true, "internalType": "address"},
        {"name": "to", "type": "address", "indexed": true, "internalType": "address"},
        {"name": "tokenId", "type": "uint256", "indexed": true, "internalType": "uint256"}
      ],
      "anonymous": false
    },
    {
      "type": "error",
      "name": "ERC721IncorrectOwner",
      "inputs": [
        {"name": "sender", "type": "address", "internalType": "address"},
        {"name": "tokenId", "type": "uint256", "internalType": "uint256"},
        {"name": "owner", "type": "address", "internalType": "address"}
      ]
    },
    {
      "type": "error",
      "name": "ERC721InsufficientApproval",
      "inputs": [
        {"name": "operator", "type": "address", "internalType": "address"},
        {"name": "tokenId", "type": "uint256", "internalType": "uint256"}
      ]
    },
    {
      "type": "error",
      "name": "ERC721InvalidApprover",
      "inputs": [
        {"name": "approver", "type": "address", "internalType": "address"}
      ]
    },
    {
      "type": "error",
      "name": "ERC721InvalidOperator",
      "inputs": [
        {"name": "operator", "type": "address", "internalType": "address"}
      ]
    },
    {
      "type": "error",
      "name": "ERC721InvalidOwner",
      "inputs": [
        {"name": "owner", "type": "address", "internalType": "address"}
      ]
    },
    {
      "type": "error",
      "name": "ERC721InvalidReceiver",
      "inputs": [
        {"name": "receiver", "type": "address", "internalType": "address"}
      ]
    },
    {
      "type": "error",
      "name": "ERC721InvalidSender",
      "inputs": [
        {"name": "sender", "type": "address", "internalType": "address"}
      ]
    },
    {
      "type": "error",
      "name": "ERC721NonexistentToken",
      "inputs": [
        {"name": "tokenId", "type": "uint256", "internalType": "uint256"}
      ]
    },
    {
      "type": "error",
      "name": "OwnableInvalidOwner",
      "inputs": [
        {"name": "owner", "type": "address", "internalType": "address"}
      ]
    },
    {
      "type": "error",
      "name": "OwnableUnauthorizedAccount",
      "inputs": [
        {"name": "account", "type": "address", "internalType": "address"}
      ]
    },
    {"type": "error", "name": "ReentrancyGuardReentrantCall", "inputs": []}
  ];
}
