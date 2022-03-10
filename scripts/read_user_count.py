from brownie import MtgTradingReference, accounts, config

# Locate all interactions with the Smart Contract here with the right Account to interact with

def read_user_count():
    traderef = MtgTradingReference[-1]
    print_count = traderef.getUserCount()
    print(print_count)

def main():
    read_user_count()