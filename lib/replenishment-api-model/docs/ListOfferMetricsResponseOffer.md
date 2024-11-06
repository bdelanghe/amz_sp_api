# AmzSpApi::ReplenishmentApiModel::ListOfferMetricsResponseOffer

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**asin** | **String** | The Amazon Standard Identification Number (ASIN). | [optional] 
**not_delivered_due_to_oos** | **Float** | The percentage of items that were not shipped out of the total shipped units over a period of time due to being out of stock. Applicable only for the PERFORMANCE timePeriodType. | [optional] 
**total_subscriptions_revenue** | **Float** | The revenue generated from subscriptions over a period of time. Applicable only for the PERFORMANCE timePeriodType. | [optional] 
**shipped_subscription_units** | [**BigDecimal**](BigDecimal.md) | The number of units shipped to the subscribers over a period of time. Applicable only for the PERFORMANCE timePeriodType. | [optional] 
**active_subscriptions** | [**BigDecimal**](BigDecimal.md) | The number of active subscriptions present at the end of the period. Applicable only for the PERFORMANCE timePeriodType. | [optional] 
**revenue_penetration** | **Float** | The percentage of total program revenue out of total product revenue. Applicable only for the PERFORMANCE timePeriodType. | [optional] 
**next30_day_total_subscriptions_revenue** | **Float** | The forecasted total subscription revenue for the next 30 days. Applicable only for the FORECAST timePeriodType. | [optional] 
**next60_day_total_subscriptions_revenue** | **Float** | The forecasted total subscription revenue for the next 60 days. Applicable only for the FORECAST timePeriodType. | [optional] 
**next90_day_total_subscriptions_revenue** | **Float** | The forecasted total subscription revenue for the next 90 days. Applicable only for the FORECAST timePeriodType. | [optional] 
**next30_day_shipped_subscription_units** | [**BigDecimal**](BigDecimal.md) | The forecasted shipped subscription units for the next 30 days. Applicable only for the FORECAST timePeriodType. | [optional] 
**next60_day_shipped_subscription_units** | [**BigDecimal**](BigDecimal.md) | The forecasted shipped subscription units for the next 60 days. Applicable only for the FORECAST timePeriodType. | [optional] 
**next90_day_shipped_subscription_units** | [**BigDecimal**](BigDecimal.md) | The forecasted shipped subscription units for the next 90 days. Applicable only for the FORECAST timePeriodType. | [optional] 
**time_interval** | [**TimeInterval**](TimeInterval.md) |  | [optional] 
**currency_code** | **String** | The currency code in ISO 4217 format. | [optional] 

