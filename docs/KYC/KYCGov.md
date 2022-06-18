# KYCGov









## Methods

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

### SetType

```solidity
function SetType(uint8 _type, string _data) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _type | uint8 | undefined |
| _data | string | undefined |

### owner

```solidity
function owner() external view returns (address)
```



*Returns the address of the current owner.*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### renounceOwnership

```solidity
function renounceOwnership() external nonpayable
```



*Leaves the contract without owner. It will not be possible to call `onlyOwner` functions anymore. Can only be called by the current owner. NOTE: Renouncing ownership will leave the contract without an owner, thereby removing any functionality that is only available to the owner.*


### setOrg

```solidity
function setOrg(address _org) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _org | address | undefined |

### transferOwnership

```solidity
function transferOwnership(address newOwner) external nonpayable
```



*Transfers ownership of the contract to a new account (`newOwner`). Can only be called by the current owner.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| newOwner | address | undefined |

### unsetOrg

```solidity
function unsetOrg(address _org) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _org | address | undefined |



## Events

### OwnershipTransferred

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| previousOwner `indexed` | address | undefined |
| newOwner `indexed` | address | undefined |



