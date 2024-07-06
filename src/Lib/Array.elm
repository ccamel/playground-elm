module Lib.Array exposing (BoundedArray, appendToBoundedArray, createBoundedArray, resetBoundedArray, resizeBoundedArray)

import Array exposing (Array, get, indexedMap)
import Maybe exposing (withDefault)


type alias BoundedArray a =
    { values : Array a
    , length : Int
    , capacity : Int
    , default : () -> a
    }


{-| append a value to the end of the bounded array.
if length of the array has reached the capacity, the elements are shifted to the left to make
a new place for the inserted value.
-}
appendToBoundedArray : a -> BoundedArray a -> BoundedArray a
appendToBoundedArray value ({ values, length, capacity, default } as array) =
    let
        withDefaultValue =
            withDefault (default ())

        shiftLeft i _ =
            get (i + 1) values |> withDefaultValue

        ( shiftedValues, newLength ) =
            if length == capacity then
                ( indexedMap shiftLeft values
                , capacity - 1
                )

            else
                ( values, length )
    in
    { array
        | values = Array.set newLength value shiftedValues
        , length = newLength + 1
    }


{-| create a new bounded array with the given capacity and default value.
-}
createBoundedArray : Int -> (() -> a) -> BoundedArray a
createBoundedArray capacity default =
    { values = Array.initialize capacity (always <| default ()), length = 0, capacity = capacity, default = default }


{-| reset the bounded array to its initial state.
-}
resetBoundedArray : BoundedArray a -> BoundedArray a
resetBoundedArray { capacity, default } =
    createBoundedArray capacity default


{-| returns a new bounded array with the given capacity
-}
resizeBoundedArray : Int -> BoundedArray a -> BoundedArray a
resizeBoundedArray capacity { default } =
    createBoundedArray capacity default
