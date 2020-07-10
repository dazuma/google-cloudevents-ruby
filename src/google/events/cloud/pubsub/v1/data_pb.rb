# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/events/cloud/pubsub/v1/data.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/events/cloud/pubsub/v1/data.proto", :syntax => :proto3) do
    add_message "google.events.cloud.pubsub.v1.MessagePublishedData" do
      optional :message, :message, 1, "google.events.cloud.pubsub.v1.PubsubMessage"
      optional :subscription, :string, 2
    end
    add_message "google.events.cloud.pubsub.v1.PubsubMessage" do
      optional :data, :bytes, 1
      map :attributes, :string, :string, 2
      optional :message_id, :string, 3
    end
  end
end

module Google
  module Events
    module Cloud
      module Pubsub
        module V1
          MessagePublishedData = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.events.cloud.pubsub.v1.MessagePublishedData").msgclass
          PubsubMessage = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.events.cloud.pubsub.v1.PubsubMessage").msgclass
        end
      end
    end
  end
end
