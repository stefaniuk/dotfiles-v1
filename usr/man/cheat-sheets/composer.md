# Composer

## Commands

    composer config -g github-oauth.github.com TOKEN

## File composer.json

##### Versions

 * Wildcard
    - `1.0.*` is the equivalent of `>=1.0 <1.1`
 * Tilde
    - `~1.2` is equivalent to `>=1.2 <2.0.0`
    - `~1.2.3` is equivalent to `>=1.2.3 <1.3.0`
 * Caret
    - `^1.2` is equivalent to `>=1.2.0 <1.3.0`.
    - `^1.2.3` is equivalent to `>=1.2.3 <2.0.0`
