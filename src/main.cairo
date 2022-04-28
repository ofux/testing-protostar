%lang starknet
%builtins pedersen range_check

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import (get_caller_address)

@external
func check_caller{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}():
    let (caller) = get_caller_address()
    assert caller = 42
    return ()
end

@external
func will_revert{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}():
    let v = 1
    assert v = 2
    return ()
end
