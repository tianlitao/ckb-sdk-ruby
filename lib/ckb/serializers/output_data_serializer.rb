# frozen_string_literal: true

module CKB
  module Serializers
    class OutputDataSerializer
      # @param output_data [String]
      def initialize(output_data)
        @bytes_serializer = BytesSerializer.new(output_data)
      end

      def serialize
        layout
      end

      def capacity
        [layout].pack("H*").bytesize
      end

      private

      attr_reader :bytes_serializer

      def layout
        bytes_serializer.serialize
      end
    end
  end
end