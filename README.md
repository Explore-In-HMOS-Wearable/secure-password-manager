> **Note:** To access all shared projects, get information about environment setup, and view other guides, please visit [Explore-In-HMOS-Wearable Index](https://github.com/Explore-In-HMOS-Wearable/hmos-index).

# Secure Password Manager

This app demonstrates how to store the secrets on Asset Store.

# Preview

<div>
  <img src="screenshots/ss1.png" width="24%">
  <img src="screenshots/ss2.png" width="24%">
  <img src="screenshots/ss3.png" width="24%">
  <img src="screenshots/ss4.png" width="24%">
</div>

# Use Cases

- Add account with secret.
- List accounts
- Delete account.
- Show the secrets using device screen password.

# Technology
## Stack

- **Languages**: ArkTS, ArkUI, TypeScript
- **Frameworks**: HarmonyOS SDK 5.1.0(18)
- **Tools**: DevEco Studio Version 5.1.1.823
- **Libraries**:
    - `@kit.ArkUI`
    - `@kit.ArkTS`
    - `@kit.UserAuthenticationKit`
    - `@kit.AssetStoreKit`
## Required Permissions
- `ohos.permission.STORE_PERSISTENT_DATA`
- `ohos.permission.ACCESS_BIOMETRIC`

## Development Process
<div>
<img src="screenshots/process.png" style="border-radius: 20px" />
</div>

# Directory Structure

```
entry/src/main/ets/
├───common
│       Logger.ts
├───entryability
│       EntryAbility.ets
├───entrybackupability
│       EntryBackupAbility.ets
├───model
│       AssetItem.ets
│       AssetModel.ets
├───pages
│       Index.ets
│       AddPage.ets
│       ListPage.ets
│       QueryResultPage.ets
└───utils
        Helper.ets
```

# Constraints and Restrictions

## Supported Device

* Huawei Watch 5

# License

**Secure Password Manager** is distributed under the terms of the MIT License
See the [LICENSE](./LICENSE) for more information.