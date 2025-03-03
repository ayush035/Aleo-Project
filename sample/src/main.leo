program simple_records.aleo {
    record Token {
        owner: address,
        amount: u64,
    }
    
    // Create a new token
    transition mint(amount: u64) -> Token {
        return Token {
            owner: self.caller,
            amount: amount,
        };
    }
    
    transition transfer(token: Token, receiver: address, transfer_amount: u64) -> (Token, Token) {
        assert(token.amount >= transfer_amount);
        
        let receiver_token: Token = Token {
            owner: receiver,
            amount: transfer_amount,
        };
        
        let sender_token: Token = Token {
            owner: self.caller,
            amount: token.amount - transfer_amount,
        };
        
        return (sender_token, receiver_token);
    }
}