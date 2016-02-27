# TimeZoneBug

bug for 24692076 in apple's bug reporter.
changing time zone back and forth without restarting app will have dirty cache in NSCalendar object, leading NSDateComponents.day object incorrect
