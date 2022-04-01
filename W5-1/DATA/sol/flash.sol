pragma solidity =0.6.6;

import '@uniswap/v2-core/contracts/interfaces/IUniswapV2Callee.sol';

import '../libraries/UniswapV2Library.sol';
import '../interfaces/V1/IUniswapV1Factory.sol';
import '../interfaces/V1/IUniswapV1Exchange.sol';
import '../interfaces/IUniswapV2Router01.sol';
import '../interfaces/IERC20.sol';
import '../interfaces/IWETH.sol';

pragma experimental ABIEncoderV2;
interface IUniswapV2Router{
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
}
interface IUniswapV2pair {
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function token0() external view returns (address);
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

contract ExampleFlashSwap is IUniswapV2Callee {
    address public tokenA=0x335646DF51725a4050400641109169D30d65D587;
    address public tokenB=0xa6429334BA49d01fDdFE3161e7f781ed351A7cDC;
    uint256 public test_amount=10**20;
    address public owner;
    address v2pair=0x31E3c6Fbf52937D0d339f10D382b950f9160Af12;
    address v3pair=0xF5dbA747a8489Bd27816f432bBa3eEcA1519FAF0;
    address v2router=0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address v3router=0x7a250d5630b4cf539739df2c5dacb4c659f2488d;
    constructor() public {
        owner=msg.sender;
        // uniswapV2Flash();
        IERC20(tokenB).approve(v2router,uint256(-1));
        IERC20(tokenA).approve(v2router,uint256(-1));
        IERC20(tokenB).approve(v3router,uint256(-1));
        IERC20(tokenA).approve(v3router,uint256(-1));
    }
    receive() external payable {}
    function uniswapV2Call(address sender, uint amount0, uint amount1, bytes calldata data) external override {
        (bool success,)=v3router.call(data);
        assert(success);
        IERC20(tokenA).transfer(msg.sender,test_amount);
        IERC20(tokenB).transfer(tx.origin,IERC20(tokenB).balanceOf(address(this)));
        IERC20(tokenA).transfer(tx.origin,IERC20(tokenB).balanceOf(address(this)));
    }
    function uniswapV2Flash2(bytes calldata data)external{
        address token0 = IUniswapV2pair(v2pair).token0();
        uint amountOut = IUniswapV2Router(v2router).getAmountOut(test_amount,IERC20(tokenA).balanceOf(v2pair),IERC20(tokenB).balanceOf(v2pair));
        (uint amount0Out, uint amount1Out) = tokenA == token0 ? (uint(0), amountOut) : (amountOut, uint(0));
        IERC20(tokenA).transferFrom(msg.sender,v2pair,test_amount);
        IUniswapV2pair(v2pair).swap(amount0Out, amount1Out, address(this),data);
    }
    function uniswapV2Flash(bytes calldata data)external{
        address token0 = IUniswapV2pair(v2pair).token0();
        uint amountOut = IUniswapV2Router(v2router).getAmountOut(test_amount,IERC20(tokenA).balanceOf(v2pair),IERC20(tokenB).balanceOf(v2pair));
        (uint amount0Out, uint amount1Out) = tokenA == token0 ? (uint(0), amountOut) : (amountOut, uint(0));
        IUniswapV2pair(v2pair).swap(amount0Out, amount1Out, address(this),data);
    }
}
