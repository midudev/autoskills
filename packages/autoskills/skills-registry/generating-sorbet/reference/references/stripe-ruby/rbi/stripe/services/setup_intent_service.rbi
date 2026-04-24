# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class SetupIntentService < StripeService
    # You can cancel a SetupIntent object when it's in one of these statuses: requires_payment_method, requires_confirmation, or requires_action.
    #
    # After you cancel it, setup is abandoned and any operations on the SetupIntent fail with an error. You can't cancel the SetupIntent for a Checkout Session. [Expire the Checkout Session](https://docs.stripe.com/docs/api/checkout/sessions/expire) instead.
    sig {
      params(intent: String, params: T.any(::Stripe::SetupIntentCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SetupIntent)
     }
    def cancel(intent, params = {}, opts = {}); end

    # Confirm that your customer intends to set up the current or
    # provided payment method. For example, you would confirm a SetupIntent
    # when a customer hits the “Save” button on a payment method management
    # page on your website.
    #
    # If the selected payment method does not require any additional
    # steps from the customer, the SetupIntent will transition to the
    # succeeded status.
    #
    # Otherwise, it will transition to the requires_action status and
    # suggest additional actions via next_action. If setup fails,
    # the SetupIntent will transition to the
    # requires_payment_method status or the canceled status if the
    # confirmation limit is reached.
    sig {
      params(intent: String, params: T.any(::Stripe::SetupIntentConfirmParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SetupIntent)
     }
    def confirm(intent, params = {}, opts = {}); end

    # Creates a SetupIntent object.
    #
    # After you create the SetupIntent, attach a payment method and [confirm](https://docs.stripe.com/docs/api/setup_intents/confirm)
    # it to collect any required permissions to charge the payment method later.
    sig {
      params(params: T.any(::Stripe::SetupIntentCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SetupIntent)
     }
    def create(params = {}, opts = {}); end

    # Returns a list of SetupIntents.
    sig {
      params(params: T.any(::Stripe::SetupIntentListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Retrieves the details of a SetupIntent that has previously been created.
    #
    # Client-side retrieval using a publishable key is allowed when the client_secret is provided in the query string.
    #
    # When retrieved with a publishable key, only a subset of properties will be returned. Please refer to the [SetupIntent](https://docs.stripe.com/api#setup_intent_object) object reference for more details.
    sig {
      params(intent: String, params: T.any(::Stripe::SetupIntentRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SetupIntent)
     }
    def retrieve(intent, params = {}, opts = {}); end

    # Updates a SetupIntent object.
    sig {
      params(intent: String, params: T.any(::Stripe::SetupIntentUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SetupIntent)
     }
    def update(intent, params = {}, opts = {}); end

    # Verifies microdeposits on a SetupIntent object.
    sig {
      params(intent: String, params: T.any(::Stripe::SetupIntentVerifyMicrodepositsParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SetupIntent)
     }
    def verify_microdeposits(intent, params = {}, opts = {}); end
  end
end