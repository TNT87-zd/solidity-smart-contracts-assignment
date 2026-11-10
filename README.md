# Solidity-Smart-Contracts-Assignment
# Solidity Smart Contract Assignment

**Name :** Nhat Truong
**Roll No:** 29211164915
**Email :** nhattruong08072005@gmail.com

Design, deploy & test 15 Solidity smart contracts using Remix IDE and Ganache.

| # | Contract | Level | Tested on Ganache | Screenshots |
|----|-----------------|----------|-------------------|--------------------------------------|
| 01 | Storage | Basic | YES | 01_compile.jpg,  01_test2.png |
| 02 | Greeting | Basic | YES | 02_compile.jpg,  02_test2.png |
| 03 | Counter | Basic | YES | 03_compile.jpg,  03_test2.png |
| 04 | Ownable | Medium | YES | 04_compile.jpg,  04_test2.png |
| 05 | SimpleBank | Medium | YES | 05_compile.jpg,  05_test2.png |
| 06 | Voting | Medium | YES | 06_compile.jpg,  06_test2.png |
| 07 | MyToken | Medium | YES | 07_compile.jpg,  07_test2.png |
| 08 | Crowdfunding | Advanced | YES | 08_compile.jpg,  08_test2.pngg |
| 09 | Lottery | Advanced | YES | 09_compile.jpg,  09_test2.png |
| 10 | TimeLockVault | Advanced | YES | 10_compile.jpg,  10_test2.png |
| 11 | Escrow | Advanced | YES | 11_compile.jpg,  11_test2.png |
| 12 | SimpleNFT | Advanced | YES | 12_compile.jpg,  12_test2.png |
| 13 | EnglishAuction | Expert | YES | 13_compile.jpg,  13_test2.png |
| 14 | MultisigWallet | Expert | YES | 14_compile.jpg,  14_test2.png |
| 15 | StakingRewards | Expert | YES | 15_compile.jpg,  15_test2.png |

## Repository structure

```
solidity-smart-contracts-assignment/
├── README.md
├── contracts/      # 15 .sol files (01_Storage.sol ... 15_StakingRewards.sol)
├── screenshots/    # compile/deploy + test screenshots (min. 2 per contract)
└── report/
    └── REPORT.md   # short report for each contract
```

## How to run

1. Open https://remix.ethereum.org -> paste contract -> compile with 0.8.x
2. Start Ganache QUICKSTART on HTTP://127.0.0.1:7545
3. Remix: Deploy & Run -> Environment = Custom - External Http Provider -> URL `http://127.0.0.1:7545`
4. Deploy and test per the checklist in each contract file

## Tools

- Solidity ^0.8.x
- Remix IDE
- Ganache (local blockchain, 10 accounts x 100 ETH)
- Git & GitHub
