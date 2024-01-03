
import Plutus.V2.Ledger.Api (BuiltinData, ScriptContext, mkMintingPolicyScript)
import PlutusTx             (Bool, ($), (.))
import Prelude              (IO)
import Utilities            (wrapPolicy, writePolicyToFile)

{-# INLINABLE mkPolicy #-}
mkPolicy :: () -> ScriptContext -> Bool
mkPolicy _ ctx = True

{-# INLINABLE mkWrappedPolicy #-}
mkWrappedPolicy :: BuiltinData -> BuiltinData -> ()
mkWrappedPolicy = wrapPolicy mkPolicy

policy :: Scripts.MintingPolicy
policy = mkMintingPolicyScript $$(PlutusTx.compile[|| mkPolicy ||])

savePolicy :: IO ()
savePolicy = writePolicyToFile "assets/policy.plutus" policy