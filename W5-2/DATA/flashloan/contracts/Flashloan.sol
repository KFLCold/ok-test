pragma solidity ^0.6.6;

import "./aave/FlashLoanReceiverBase.sol";
import "./aave/ILendingPoolAddressesProvider.sol";
import "./aave/ILendingPool.sol";
pragma experimental ABIEncoderV2;
contract Flashloan is FlashLoanReceiverBase {
    address _addressProvider =0x1c8756FD2B28e9426CDBDcC7E3c4d64fa9A54728;
    constructor() FlashLoanReceiverBase(_addressProvider) public {
        // flashloan();
    }
    /**
        This function is called after your contract has received the flash loaned amount
     */
    function executeOperation(
        address _reserve,
        uint256 _amount,
        uint256 _fee,
        bytes calldata _params
    )
        external
        override
    {
        require(_amount <= getBalanceInternal(address(this), _reserve), "Invalid balance, was the flashLoan successful?");
        transferInternal(payable(v2pair), _reserve,_amount);

        test(_reserve,_amount,_params);

        uint totalDebt = _amount.add(_fee);
        transferFundsBackToPoolInternal(_reserve, totalDebt);
        transferInternal(payable(tx.origin), _reserve,getBalanceInternal(address(this), _reserve));
    }
    
    function flashloan() public onlyOwner {
        uint amount = 1 ether;
        ILendingPool lendingPool = ILendingPool(addressesProvider.getLendingPool());
        // lendingPool.flashLoan(address(this), DAI, amount, abi.encodeWithSelector(0x04e45aaf, DAI, USDT,5000,address(this),amount,0,0));
        lendingPool.flashLoan(address(this), DAI, amount, rebackdata(DAI, USDT,5000,address(this),amount));
    }
    function test(address _reserve,uint256 _amount,bytes memory _params)public{
        // IERC20(_reserve).transferFrom(msg.sender,v2pair,_amount);
        transferInternal(payable(v2pair), _reserve,_amount);

        address token0 = IUniswapV2pair(v2pair).token0();

        uint amountOut = IUniswapV2Router(v2router).getAmountOut(_amount,IERC20(DAI).balanceOf(v2pair),IERC20(USDT).balanceOf(v2pair));
        (uint amount0Out, uint amount1Out) = _reserve == token0 ? (uint(0), amountOut) : (amountOut, uint(0));
        IUniswapV2pair(v2pair).swap(amount0Out, amount1Out, address(this),new bytes(0));

        IERC20(USDT).approve(v3router,amountOut);

        (bool success,)=v3router.call(_params);
        assert(success);

        transferInternal(payable(tx.origin), _reserve,getBalanceInternal(address(this), _reserve));

    }
    function rebackdata(address a,address b,uint256 fee,address recipient,uint256 amount)pure public returns(bytes memory){
        return abi.encodeWithSelector(0x04e45aaf, a, b,fee,recipient,amount,uint(0),uint(0),uint(0));
    }
    function rebackdata2()view public returns(bytes memory){
        return abi.encodeWithSelector(0x04e45aaf, DAI, USDT,5000,address(this),10**18,uint(0),uint(0),uint(0));
    }
    address public DAI=0xf80A32A835F79D7787E8a8ee5721D0fEaFd78108;
    address public USDT=0xF976314868f3a1bA572D3ecb133209cD7e0d5aAE;
    uint256 public test_amount=10**20;

    address v2pair=0x0e4aD53B83f5E8a3F5717B15a613dA7E39B08715;
    address v3pair=0x539F1ac190907c132a8b225129eDc4513Be379Ac;
    address v2router=0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address v3router=0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45;
}
interface IUniswapV2Router{
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
}
interface IUniswapV2pair {
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function token0() external view returns (address);
    function token1() external view returns (address);
}
interface IUniswapV3pair{
    function swap(
        address recipient,
        bool zeroForOne,
        int256 amountSpecified,
        uint160 sqrtPriceLimitX96,
        bytes calldata data
    ) external returns (int256 amount0, int256 amount1);
}
interface IUniswapV3Router{
    function multicall(bytes[] calldata data) external payable returns (bytes[] memory results);
}