module hello_world_project::hello_world {
    use std::signer;
    
    struct Counter has key {
        value: u64,
    }
    
    public entry fun initialize(account: &signer) {
        let addr = signer::address_of(account);
        assert!(!exists<Counter>(addr), 1);
        
        move_to(account, Counter {
            value: 0,
        });
    }
    
    public entry fun increment(account: &signer) acquires Counter {
        let addr = signer::address_of(account);
        assert!(exists<Counter>(addr), 2);
        
        let counter = borrow_global_mut<Counter>(addr);
        counter.value = counter.value + 1;
    }
    
    #[view]
    public fun get_counter(addr: address): u64 acquires Counter {
        assert!(exists<Counter>(addr), 3);
        borrow_global<Counter>(addr).value
    }
    
    #[view]
    public fun exists_counter(addr: address): bool {
        exists<Counter>(addr)
    }
}
