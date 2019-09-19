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
  module ExpressionBuildable
    def build_expression
      node = yield Gandiva::Record.new(self), Gandiva::Context.new

      message = "The node passed to Gandiva::Expression must belong to Gandiva::Node"
      message << ": <#{node.class}>"
      raise ArgumentError, message unless node.is_a?(Gandiva::Node)

      result = Arrow::Field.new("result", node.return_type)
      Gandiva::Expression.new(node, result)
    end
  end
end

module Arrow
  class Schema
    include Gandiva::ExpressionBuildable
  end
end
