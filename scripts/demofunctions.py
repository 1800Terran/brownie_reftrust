from brownie import accounts, config, MtgTradingReference, network
import os

from scripts.deploy import get_account

# "Production" Testing with the rinkeby network
# Checking on Rinkeby as a live net
# How do I define which one I am using? -> the last one
# Can I do this in the console? When interacting with the contract?


# I need 3 Users
def create_trader(tradername):
    sender_account = get_account()
    if type(tradername) == str:
        
        contract = MtgTradingReference[-1]
        add_trader_transaction = contract.addTrader(tradername, {"from": sender_account})
        print("Trader added: ", tradername)
    else:
        print("tradername has to be a String")


def add_reference(ref_giver, ref_taker, message):
    # Wie gehe ich mit msg.sender um? 
    # Muss ich dann immer eine andere Addresse angeben die ich gerade nutze?
    contract = MtgTradingReference[-1]
    reference_giver = ref_giver # should not necessarily be the current address, issue-> msg.sender
    reference_taker = ref_taker # has to be given in the call
    loggedmessage = message
    add_reference = contract.addReference()


def get_user():
    pass

def get_isUser(address):
    pass

def get_usercount():
    pass

def execute_functions():
    trader = "Soeren"
    create_trader(trader)

def main():
    execute_functions()
