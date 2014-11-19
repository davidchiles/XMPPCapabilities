XMPPCapabilities
================

A quick and dirty iOS App to probe XMPP servers for all their capabilities and stream features.

## Install

```
git clone git@github.com:davidchiles/XMPPCapabilities.git
cd  XMPPCapabilities
pod install
cp ./XMPPCapabilities/Account-Template.m ./XMPPCapabilities/Account.m
```
Than edit the `testAccounts:` function to add the accounts you want to test.