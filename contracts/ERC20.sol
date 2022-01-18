pragma solidity ^0.8.0;
import "./IERC20.sol";

contract ERC20 is IERC20{
    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowances;
    uint256 public totalSupply;
    string public name;
    string public symbol;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    function decimals() public view virtual returns (uint8) {
        return 18;
    }

    function balanceOf(address _account) public view virtual override returns (uint256) {
        return balances[_account];
    }

    function transfer(address _to, uint256 _amount) public virtual override returns (bool) {
        _transfer(msg.sender, _to, _amount);
        return true;
    }

    function _transfer(address _from, address _to, uint256 _amount) internal virtual {
        require(_from != address(0), "Transfer from the zero address");
        require(_to != address(0), "Transfer to the zero address");

        uint256 senderBalance = balances[_from];
        require(senderBalance >= _amount, "Transfer amount exceeds balance");
        balances[_from] = senderBalance - _amount;
        balances[_to] += _amount;

        emit Transfer(_from, _to, _amount);
    }
    
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function _approve(address owner,address spender,uint256 amount) internal virtual {
        require(owner != address(0), "Approve from the zero address");
        require(spender != address(0), "Approve to the zero address");

        allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function transferFrom(address _from, address _to, uint256 amount) public virtual override returns (bool) {
        uint256 currentAllowance = allowances[_from][msg.sender];
        
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "Amount exceeds allowance");
            _approve(_from, msg.sender, currentAllowance - amount);
        }

        _transfer(_from, _to, amount);
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(msg.sender, spender, allowances[msg.sender][spender] + addedValue);
        return true;
    }

     function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        uint256 currentAllowance = allowances[msg.sender][spender];
        require(currentAllowance >= subtractedValue, "Decreased allowance below zero");

        _approve(msg.sender, spender, currentAllowance - subtractedValue);

        return true;
    }

    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "Mint to the zero address");

        totalSupply += amount;
        balances[account] += amount;
        emit Transfer(address(0), account, amount);
    }

    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "Burn from the zero address");

        uint256 accountBalance = balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        balances[account] = accountBalance - amount;
        totalSupply -= amount;

        emit Transfer(account, address(0), amount);
    }
}
