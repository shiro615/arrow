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
    class If
      def initialize(condition_builder, then_builder, else_builder)
        @condition = condition_builder
        @then = then_builder
        @else = else_builder
      end

      def build
        result = Arrow::Field.new("result", node.return_type)
        Gandiva::Expression.new(node, result)
      end

      def node
        @node ||= Gandiva::IfNode.new(@condition.node,
                                      @then.node,
                                      @else.node,
                                      @then.node.return_type)
      end
    end
  end
end
