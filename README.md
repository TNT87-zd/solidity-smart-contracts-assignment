# Solidity-Smart-Contracts-Assignment

**Name :** Truong Nhat Truong
**Roll No:** 29211164915
**Email :** nhattruong08072005@gmail.com

Design, deploy & test 15 Solidity smart contracts using Remix IDE and Ganache.

| # | Contract | Level | Tested on Ganache | Screenshots |
|----|-----------------|----------|-------------------|--------------------------------------|
| 01 | Storage | Basic | YES | 01-compile.jpg, 01-test2.jpg |
| 02 | Greeting | Basic | YES | 02-compile.jpg, 02-test2.jpg  |
| 03 | Counter | Basic | YES | 03-compile.jpg, 03-test2.jpg  |
| 04 | Ownable | Medium | YES | 04-compile.jpg, 04-test2.jpg  |
| 05 | SimpleBank | Medium | YES | 05-compile.jpg, 05-test2.jpg |
| 06 | Voting | Medium | YES | 06-compile.jpg, 06-test2.jpg  |
| 07 | MyToken | Medium | YES | 07-compile.jpg, 07-test2.jpg  |
| 08 | Crowdfunding | Advanced | YES | 08-compile.jpg, 08-test2.jpg  |
| 09 | Lottery | Advanced | YES | 09-compile.jpg, 09-test2.jpg |
| 10 | TimeLockVault | Advanced | YES | 10-compile.jpg, 10-test2.jpg  |
| 11 | Escrow | Advanced | YES | 11-compile.jpg, 11-test2.jpg  |
| 12 | SimpleNFT | Advanced | YES | 12-compile.jpg, 12-test2.jpg  |
| 13 | EnglishAuction | Expert | YES | 13-compile.jpg, 13-test2.jpg  |
| 14 | MultisigWallet | Expert | YES | 14-compile.jpg, 14-test2.jpg  |
| 15 | StakingRewards | Expert | YES | 15-compile.jpg, 15-test2.jpg  |

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
