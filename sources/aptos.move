module MyModule::SimpleNFT {

    use aptos_framework::signer;
    use std::string;

    /// Struct representing a simple NFT
    struct NFT has key, store,drop {
        name: string::String,
        uri: string::String,
    }

    /// Storage for an account's NFT
    struct NFTStore has key {
        nft: NFT,
        minted: bool,
    }

    /// Initialize NFT storage for the creator
    public fun init_store(account: &signer) {
        move_to(account, NFTStore {
            nft: NFT { name: string::utf8(b""), uri: string::utf8(b"") },
            minted: false,
        });
    }

    /// Mint the NFT
    public fun mint_nft(account: &signer, name: string::String, uri: string::String) acquires NFTStore {
        let store = borrow_global_mut<NFTStore>(signer::address_of(account));
        assert!(!store.minted, 1); // Only allow one mint per account
        store.nft = NFT { name, uri };
        store.minted = true;
    }
}
