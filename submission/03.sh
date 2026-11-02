# Create treasure wallet.
bitcoin-cli -regtest createwallet "treasurewallet" > /dev/null

# Generate mining address.
mining_address=$(bitcoin-cli -regtest -rpcwallet=treasurewallet getnewaddress)

# Mine 101 blocks.
bitcoin-cli -regtest generatetoaddress 101 "$mining_address" > /dev/null

# Create a SegWit address.
address=$(bitcoin-cli -regtest -rpcwallet=btrustwallet getnewaddress "" bech32)

# Set an explicit fee rate.
bitcoin-cli -regtest -rpcwallet=treasurewallet -named sendtoaddress address="$address" amount=1 fee_rate=10 > /dev/null

# Confirm the transaction.
bitcoin-cli -regtest generatetoaddress 1 "$mining_address" > /dev/null

# Unload treasure wallet.
bitcoin-cli -regtest unloadwallet "treasurewallet" > /dev/null

# Return only the address.
echo "$address"