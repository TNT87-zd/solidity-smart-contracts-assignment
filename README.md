# Solidity-Smart-Contracts-Assignment
# Solidity Smart Contract Assignment

**Name :** Nhat Truong
**Roll No:** 29211164915
**Email :** your-email@example.com

Design, deploy & test 15 Solidity smart contracts using Remix IDE and Ganache.

| # | Contract | Level | Tested on Ganache | Screenshots |
|----|-----------------|----------|-------------------|--------------------------------------|
| 01 | Storage | Basic | YES | 01_compile.png, 01_test1.png, 01_test2.png |
| 02 | Greeting | Basic | YES | 02_compile.png, 02_test1.png, 02_test2.png |
| 03 | Counter | Basic | YES | 03_compile.png, 03_test1.png, 03_test2.png |
| 04 | Ownable | Medium | YES | 04_compile.png, 04_test1.png, 04_test2.png |
| 05 | SimpleBank | Medium | YES | 05_compile.png, 05_test1.png, 05_test2.png |
| 06 | Voting | Medium | YES | 06_compile.png, 06_test1.png, 06_test2.png |
| 07 | MyToken | Medium | YES | 07_compile.png, 07_test1.png, 07_test2.png |
| 08 | Crowdfunding | Advanced | YES | 08_compile.png, 08_test1.png, 08_test2.png |
| 09 | Lottery | Advanced | YES | 09_compile.png, 09_test1.png, 09_test2.png |
| 10 | TimeLockVault | Advanced | YES | 10_compile.png, 10_test1.png, 10_test2.png |
| 11 | Escrow | Advanced | YES | 11_compile.png, 11_test1.png, 11_test2.png |
| 12 | SimpleNFT | Advanced | YES | 12_compile.png, 12_test1.png, 12_test2.png |
| 13 | EnglishAuction | Expert | YES | 13_compile.png, 13_test1.png, 13_test2.png |
| 14 | MultisigWallet | Expert | YES | 14_compile.png, 14_test1.png, 14_test2.png |
| 15 | StakingRewards | Expert | YES | 15_compile.png, 15_test1.png, 15_test2.png |

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
