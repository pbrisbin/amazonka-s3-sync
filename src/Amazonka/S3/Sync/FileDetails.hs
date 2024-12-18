module Amazonka.S3.Sync.FileDetails
  ( FileDetails (..)
  , getFileDetails
  , getFileDetailsIfExists
  ) where

import Amazonka.S3.Sync.Prelude

import Control.Monad.Directory

data FileDetails = FileDetails
  { size :: Integer
  , mtime :: UTCTime
  }
  deriving stock (Eq, Show)

getFileDetails :: MonadDirectory m => Path Abs File -> m FileDetails
getFileDetails p = do
  FileDetails
    <$> getFileSize p
    <*> getModificationTime p

getFileDetailsIfExists
  :: MonadDirectory m => Path Abs File -> m (Maybe FileDetails)
getFileDetailsIfExists p = do
  exists <- doesFileExist p

  if exists
    then Just <$> getFileDetails p
    else pure Nothing
