module ShakePandoc where

import Development.Shake
import Development.Shake.FilePath

-- We use different flags based on the file extension of the markdown input
mdToHtmlFlags :: FilePath -> String
mdToHtmlFlags fp | takeExtension fp == ".lhs" = "-f markdown+lhs" ++ outFlags
                 | otherwise = "-f markdown" ++ outFlags
  where outFlags = " -t html5 --mathjax"

allMdFilesBelow :: FilePath -> Action [FilePath]
allMdFilesBelow = flip getDirectoryFiles ["//*.md", "//*.lhs"]

allHtmlTargetsBelow :: FilePath -> Action [FilePath]
allHtmlTargetsBelow =
  fmap (map $ flip replaceExtension ".html") . allMdFilesBelow

mdToInlineHtml :: FilePath -> Action ()
mdToInlineHtml = buildHtmlFromMd []

mdToHtmlDoc :: FilePath -> Action ()
mdToHtmlDoc = buildHtmlFromMd ["-s"]

buildHtmlFromMd :: [String] -> FilePath -> Action ()
buildHtmlFromMd flags = \out -> do
  let md  = out -<.> "md"
      lhs = out -<.> "lhs"
  -- prefer markdown, but if it doesn't exist check for literate haskell
  input <- fmap (\hasMd -> if hasMd then md else lhs) $ doesFileExist md
  need [input]
  cmd "pandoc" [input] (mdToHtmlFlags input) flags "-o" [out]
