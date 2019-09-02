# frozen_string_literal: true

module CKB
  module Serializers
    class HeaderDepSerializer
      # @param header_dep [String]
      def initialize(header_dep)
        @byte32_serializer = Byte32Serializer.new(header_dep)
      end

      def serialize
        layout
      end

      def capacity
        [layout].pack("H*").bytesize
      end

      private

      attr_reader :byte32_serializer

      def layout
        body
      end

      def body
        byte32_serializer.serialize
      end
    end
  end
end