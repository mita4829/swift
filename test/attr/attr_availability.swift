// RUN: %swift %s -parse -verify

@availability(*, unavailable)
func unavailable_func() {}

@availability(*, unavailable, message="message")
func unavailable_func_with_message() {}

@availability(iOS, unavailable)
@availability(OSX, unavailable)
func unavailable_multiple_platforms() {}

@availability(badPlatform, unavailable) // expected-error {{unknown platform 'badPlatform' for attribute 'availability'}}
func unavailable_bad_platform() {}

@!availability(*, unavailable) // expected-error {{attribute may not be inverted}}
func availabilityInvalidInversion() {}

// Handle unknown platform.
@availability(HAL9000, unavailable) // expected-error {{unknown platform 'HAL9000'}}
func availabilityUnknownPlatform() {}

// <rdar://problem/17669805> Availability can't appear on a typealias
@availability(*, unavailable, message="oh no you dont")
typealias int = Int

var x : int // expected-error {{'int' is unavailable: oh no you dont}}
