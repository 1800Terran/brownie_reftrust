from brownie import MtgTradingReference, accounts

# What testcases do I need?
# Check if I can withdraw funds
# Check if 

# Check if Logs are emitted
# Chec




def test_deploy():
    # TESTING!
    # Arranging | Preparing test
    account = accounts[0]
    # Acting | Doing something
    reftrust = MtgTradingReference.deploy({"from": account})
    starting_value = reftrust.getUserCount()
    expected = 0
    # Asserting
    assert starting_value == expected

def test_updating_user():
    # Arrange
    account = accounts[0]
    reftrust = MtgTradingReference.deploy({"from": account})
    starting_value = reftrust.getUserCount()
    # Act
    expected = 1
    transaction = reftrust.addTrader("Hendrik", {"from": account})
    updated_value = reftrust.getUserCount()
    # Assert
    assert updated_value == expected



