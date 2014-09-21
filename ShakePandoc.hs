module ShakePandoc where

import Development.Shake
import Development.Shake.FilePath

mdToHtmlFlags :: String
mdToHtmlFlags = "-f markdown -t html5"

mdToInlineHtml :: FilePath -> Action ()
mdToInlineHtml = buildHtmlFromMd []

mdToHtmlDoc :: FilePath -> Action ()
mdToHtmlDoc = buildHtmlFromMd ["-s"]

buildHtmlFromMd :: [String] -> FilePath -> Action ()
buildHtmlFromMd flags = \out -> do
  let md = out -<.> "md"
  need [md]
  cmd "pandoc" [md] mdToHtmlFlags flags "-o" [out]
