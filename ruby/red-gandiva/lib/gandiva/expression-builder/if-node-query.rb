# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

module Gandiva
  class ExpressionBuilder
    class IfNodeQuery
      def initialize(condition)
        @condition_builders = [condition]
        @then_builders = []
      end

      def then(builder)
        @then_builders << builder
        self
      end

      def elsif(builder)
        @condition_builders << builder
        self
      end

      def else(builder)
        to_expression_builder(builder)
      end

      private

      def to_expression_builder(builder)
        node_size = @condition_builders.size - 1
        (0..node_size).reverse_each do |i|
          builder = build_if_expression_builder(builder, i)
        end
        builder
      end

      def build_if_expression_builder(builder, i)
        If.new(@condition_builders[i],
               @then_builders[i],
               builder)
      end
    end
  end
end
