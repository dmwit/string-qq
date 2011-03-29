{-# LANGUAGE TemplateHaskell #-}

-- | QuasiQuoter for non-interpolated strings, texts and bytestrings.
--
-- The "s" quoter contains a multi-line string with no interpolation at all:
--
-- @
-- {-\# LANGUAGE QuasiQuotes #-}
-- import Data.Text (Text)
-- import Data.String.Quote
-- foo :: Text -- "String", "ByteString" etc also works
-- foo = [s|
-- 
-- Well here is a
--     multi-line string!
-- 
-- |]
-- @
--
-- Any instance of the IsString type is permitted.
--
module Data.String.Quote (s) where
import GHC.Exts (IsString(..))
import qualified Language.Haskell.TH as TH
import Language.Haskell.TH.Quote

-- | QuasiQuoter for a non-interpolating IsString literal. The pattern portion is undefined.
s :: QuasiQuoter
s = QuasiQuoter ((\a -> [|fromString a|]) . filter (/= '\r'))
                 (error "Cannot use q as a pattern")
                 (error "Cannot use q as a type")
                 (error "Cannot use q as a dec")

