%lang starknet

@contract_interface
namespace BasicContract:
    func will_revert():
    end

    func check_caller():
    end
end

@external
func test_start_prank{syscall_ptr : felt*, range_check_ptr}():
    alloc_locals

    local contract_a_address : felt
    %{ 
        ids.contract_a_address = deploy_contract("./src/main.cairo").contract_address
    %}

    %{ start_prank(42) %}
    BasicContract.check_caller(contract_address=contract_a_address) # <--- THE TEST SHOULD PASS, but it fails
    %{ stop_prank() %}

    return ()
end

@external
func test_expect_revert{syscall_ptr : felt*, range_check_ptr}():
    alloc_locals

    local contract_a_address : felt
    %{ 
        ids.contract_a_address = deploy_contract("./src/main.cairo").contract_address
    %}

    %{ stop_expecting_revert = expect_revert() %}
    BasicContract.will_revert(contract_address=contract_a_address)
    %{ stop_expecting_revert() %}

    let v = 1
    assert v = 2 # <--- THE TEST SHOULD FAIL, but it passes because of expect_revert() cheatcode

    return ()
end
