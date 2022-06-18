# IDRegistry









## Methods

### SetAccess

```solidity
function SetAccess(bytes32 _hash, address _veri) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _hash | bytes32 | undefined |
| _veri | address | undefined |

### SetKYC

```solidity
function SetKYC(bytes32 _hash, uint8 _id, address _veri) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _hash | bytes32 | undefined |
| _id | uint8 | undefined |
| _veri | address | undefined |

### SetType

```solidity
function SetType(uint8 _type, string _data) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _type | uint8 | undefined |
| _data | string | undefined |

### fetchHasaccess

```solidity
function fetchHasaccess(bytes32 _hash, address _addr) external view returns (bool)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _hash | bytes32 | undefined |
| _addr | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### fetchType

```solidity
function fetchType(uint8 _type) external view returns (string)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _type | uint8 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | string | undefined |

### fetchUserData

```solidity
function fetchUserData(bytes32 _hash, uint8 _type) external view returns (struct IDRegistry.userStruct)
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




