# Adding a Paywall

### Adding the Helper file
* Download/copy the helper file
* Put the helper file into the helpers folder
* Edit the helper file to edit routes/@user
* Call the helper in Application Helper
```
include BillingHelper
```
* Call Application Helper in the Application controller
```
include ApplicationHelper
```

* Add this to controllers you want to pay wall
```
before_action :check_billing
```