pragma solidity 0.5.2;

import "../modules/license/ILicenseController.sol";
import "../modules/registry/IRegistryController.sol";
import "../modules/query/IQueryController.sol";
import "../shared/WithRegistry.sol";

contract DAOService is WithRegistry {
    bytes32 public constant NAME = "DAO";

    constructor(address _registry) public WithRegistry(_registry) {}

    /* License */
    function approveRegistration(uint256 _registrationId)
        external
        returns (uint256 _productId)
    {
        _productId = license().approveRegistration(_registrationId);
    }

    function declineRegistration(uint256 _registrationId) external {
        license().declineRegistration(_registrationId);
    }

    function disapproveProduct(uint256 _productId) external {
        license().disapproveProduct(_productId);
    }

    function reapproveProduct(uint256 _productId) external {
        license().reapproveProduct(_productId);
    }

    function pauseProduct(uint256 _productId) external {
        license().pauseProduct(_productId);
    }

    function unpauseProduct(uint256 _productId) external {
        license().unpauseProduct(_productId);
    }

    /* Registry */
    function registerInRelease(
        uint256 _release,
        bytes32 _contractName,
        address _contractAddress
    ) external {
        registryStorage().registerInRelease(
            _release,
            _contractName,
            _contractAddress
        );
    }

    function register(bytes32 _contractName, address _contractAddress)
        external
    {
        registryStorage().register(_contractName, _contractAddress);
    }

    function deregisterInRelease(uint256 _release, bytes32 _contractName)
        external
    {
        registryStorage().deregisterInRelease(_release, _contractName);
    }

    function deregister(bytes32 _contractName) external {
        registryStorage().deregister(_contractName);
    }

    function prepareRelease() external returns (uint256 _release) {
        _release = registryStorage().prepareRelease();
    }

    /* Query */
    function activateOracleType(bytes32 _oracleTypeName) external {
        query().activateOracleType(_oracleTypeName);
    }

    function activateOracle(uint256 _oracleId) external {
        query().activateOracle(_oracleId);
    }

    function assignOracleToOracleType(
        bytes32 _oracleTypeName,
        uint256 _oracleId
    ) external {
        query().assignOracleToOracleType(_oracleTypeName, _oracleId);
    }

    /* Lookup */
    function license() internal view returns (ILicenseController) {
        return ILicenseController(registry.getContract("License"));
    }

    function registryStorage() internal view returns (IRegistryController) {
        return IRegistryController(registry.getContract("Registry"));
    }

    function query() internal view returns (IQueryController) {
        return IQueryController(registry.getContract("Query"));
    }
}
