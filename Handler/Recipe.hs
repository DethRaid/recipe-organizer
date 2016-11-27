module Handler.Recipe where

import Import

unpackMaybe :: Maybe Text -> Text
unpackMaybe Nothing = ""
unpackMaybe (Just a) = a

getRecipeR :: Text -> Handler Html
getRecipeR givenName = do
    recipeEntityMaybe <- runDB $ selectFirst [RecipeName ==. givenName] []
    case recipeEntityMaybe of
        Nothing -> defaultLayout ""
        Just (Entity _ recipe) ->
            defaultLayout $(widgetFile "recipe")

putRecipeR :: RecipeId -> Handler Value
putRecipeR recipeId = do
    recipe <- requireJsonBody :: Handler Recipe
    _ <- runDB $ replace recipeId recipe
    sendResponseStatus status200 ("UPDATED" :: Text)

deleteRecipeR :: RecipeId -> Handler Value
deleteRecipeR recipeId = do
    runDB $ delete recipeId
    sendResponseStatus status200 ("DELETED" :: Text)
