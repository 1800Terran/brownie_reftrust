from brownie import accounts, config, MtgTradingReference, network
import os


def deploy_ref_trust():
    # Like that, the private keys are not uploaded in Git.
    # rinkeby_account = os.getenv("RINKEBY_1_PK")
    # my_account = accounts.load("terran")
    # 
    host_account = get_account()
    print("Account loaded")
    ref_trust = MtgTradingReference.deploy({"from": host_account})
    print("contract deployed")
    
    # create_user_1 = ref_trust.addTrader("Hendrik", {"from": host_account})
    # create_user_2 = ref_trust.addTrader("Hendrik", {"from": host_account})
    # create_user_3 = ref_trust.addTrader("Hendrik", {"from": host_account})
    transaction = ref_trust.addTrader("Katrin", {"from": host_account})
    transaction.wait(1)
    updated_user_count = ref_trust.getUserCount()
    print("User count: ", updated_user_count)

def add_dummyusers():
    if network.show_active() == "development":
        pass
    else:
        return accounts.add(config["wallets"]["from_key"])


def get_account():
    # When working on a dev chain it should use the default account. if testnet -> .env accounts
    if network.show_active() == "development":
        return accounts[0]
    else:
        return accounts.add(config["wallets"]["from_key"])


def main():
    deploy_ref_trust()


