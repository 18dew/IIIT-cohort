// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFTContract is AccessControl, ERC721, Pausable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;

    string private uriBase;

    bytes32 public constant PAUSE_ROLE = keccak256("PAUSE_ROLE");

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    bytes32 public constant STAKING_ROLE = keccak256("STAKING_ROLE");

    mapping(bytes32 => bool) private isMint;

    mapping(bytes32 => uint256) private invTokenID;

    mapping(uint256 => NFTStruct) private NFTMap;

    mapping(address => bool) private addressLock;

    mapping(address => uint256) private coolDown;

    struct NFTStruct {
        string Name;
        bytes32 hash;
        string uri;
    }

    modifier isNotMinted(string memory Name) {
        bytes32 hash = keccak256(abi.encodePacked(Name));
        require(isMint[hash] == false, "NFT : Token String already Minted");
        _;
    }

    modifier isLocked(address _addr) {
        require(addressLock[_addr] == true);
        _;
    }

    modifier isUnLocked(address _addr) {
        require(addressLock[_addr] == false);
        _;
    }

    event mintEvent(string _id, bytes32 _hash, uint256 _counter);

    constructor(string memory name_, string memory symbol_) AccessControl() ERC721(name_, symbol_) Pausable() {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setRoleAdmin(PAUSE_ROLE, DEFAULT_ADMIN_ROLE);
        _setRoleAdmin(MINTER_ROLE, DEFAULT_ADMIN_ROLE);
    }

    function _baseURI() internal view override returns (string memory) {
        return uriBase;
    }

    function setURIBase(string memory _uri) external onlyRole(DEFAULT_ADMIN_ROLE) returns (bool) {
        uriBase = _uri;
        return true;
    }

    function setTokenURI(uint256 tokenId, string memory _uri) external returns (bool) {
        require(_exists(tokenId), "ERC721URIStorage: URI query for nonexistent token");
        require(ownerOf(tokenId) == msg.sender, "ERC721URIStorage: URI query for conflicting token");
        NFTMap[tokenId].uri = _uri;
        return true;
    }

    function pauseToken() external onlyRole(PAUSE_ROLE) returns (bool) {
        _pause();
        return true;
    }

    function tokenURLS(uint256 tokenId) public view returns (string memory) {
        require(_exists(tokenId), "ERC721URIStorage: URI query for nonexistent token");
        string memory _tokenURI = NFTMap[tokenId].uri;
        string memory base = _baseURI();
        return string(abi.encodePacked(base, _tokenURI));
    }

    function unpauseToken() external onlyRole(PAUSE_ROLE) returns (bool) {
        _unpause();
        return true;
    }

    function mint(address to, string memory tokenDetails)
    public
    virtual
    isNotMinted(tokenDetails)
    onlyRole(MINTER_ROLE)
    returns (bool)
    {
        _tokenIds.increment();
        uint256 tokenID = _tokenIds.current();
        bytes32 hash = keccak256(abi.encodePacked(tokenDetails));
        NFTMap[tokenID] = NFTStruct(tokenDetails, hash, "");
        isMint[hash] = true;
        invTokenID[hash] = tokenID;
        emit mintEvent(tokenDetails, hash, tokenID);
        _safeMint(to, tokenID);
        return true;
    }

    function LockAddress(address _addr) public virtual isUnLocked(_addr) onlyRole(STAKING_ROLE) returns (bool) {
        addressLock[_addr] = true;
        return true;
    }

    function UnlockAddress(address _addr) public virtual isLocked(_addr) onlyRole(STAKING_ROLE) returns (bool) {
        addressLock[_addr] = false;
        return true;
    }

    function fetchTokenDetails(uint256 _tokenID) public view virtual returns (string memory tokenDetail, bytes32 hash) {
        tokenDetail = NFTMap[_tokenID].Name;
        hash = NFTMap[_tokenID].hash;
    }

    function fetchMinted(string memory tokenDetail) public view virtual returns (bool) {
        bytes32 hash = keccak256(abi.encodePacked(tokenDetail));
        return isMint[hash];
    }

    function fetchTokenID(string memory tokenDetail) public view virtual returns (uint256) {
        bytes32 hash = keccak256(abi.encodePacked(tokenDetail));
        return invTokenID[hash];
    }

    function fetchCoolDown(address _addr) public view virtual returns (uint256) {
        return coolDown[_addr];
    }

    function totalSupply() public view virtual returns (uint256) {
        return _tokenIds.current();
    }

    /**
     * @dev See {ERC20-_beforeTokenTransfer}.
     *
     * Requirements:
     *
     * - the contract must not be paused.
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override {
        super._beforeTokenTransfer(from, to, amount);
        require(!paused(), "ERC721Pausable: token transfer while paused");
        require(!addressLock[from], "ERC721Pausable: Address Locked");
        coolDown[to] = block.number;
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
