require "../../spec_helper"

module Awscr
  module Signer
    module Presigned
      describe Url do
        it "raises on unsupported method" do
          scope = Scope.new("us-east-1", "s3", Time.now)
          creds = Credentials.new("AKIAIOSFODNN7EXAMPLE",
            "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY")

          options = Url::Options.new(
            "/test.txt", "examplebucket")
          url = Url.new(scope, creds, options)

          expect_raises do
            url.for(:test)
          end
        end

        describe "get" do
          it "generates a correct url" do
            Timecop.freeze(Time.new(2013, 5, 24)) do
              scope = Scope.new("us-east-1", "s3", Time.now)
              creds = Credentials.new("AKIAIOSFODNN7EXAMPLE",
                "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY")

              options = Url::Options.new(
                "/test.txt", "examplebucket")
              url = Url.new(scope, creds, options)

              url.for(:get)
                 .should eq("https://s3.amazonaws.com/examplebucket/test.txt?X-Amz-Expires=86400&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIOSFODNN7EXAMPLE%2F20130524%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20130524T000000Z&X-Amz-SignedHeaders=host&X-Amz-Signature=733255ef022bec3f2a8701cd61d4b371f3f28c9f193a1f02279211d48d5193d7")
            end
          end
        end
      end
    end
  end
end
