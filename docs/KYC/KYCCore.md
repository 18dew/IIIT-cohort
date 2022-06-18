# KYCCore









## Methods

### Rate

```solidity
function Rate() external view returns (uint256)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### SetIDRegistry

```solidity
function SetIDRegistry(address _orgR) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _orgR | address | undefined |

### SetOrgRegistry

```solidity
function SetOrgRegistry(address _orgR) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _orgR | address | undefined |

### SetRate

```solidity
function SetRate(uint256 _rate) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _rate | uint256 | undefined |

### SetToken

```solidity
function SetToken(address _token) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _token | address | undefined |

### addRecord

```solidity
function addRecord(bytes32 _hash, uint8 _type) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _hash | bytes32 | undefined |
| _type | uint8 | undefined |

### purchaseRecord

```solidity
function purchaseRecord(bytes32 _hash, uint8 _type) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _hash | bytes32 | undefined |
| _type | uint8 | undefined |

### viewRecord

```solidity
function viewRecord(bytes32 _hash, uint8 _type) external view returns (struct IDRegistry.userStruct)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _hash | bytes32 | undefined |
| _type | uint8 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | IDRegistry.userStruct | undefined |




