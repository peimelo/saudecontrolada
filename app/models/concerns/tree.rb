module Tree
  extend ActiveSupport::Concern

  require "will_paginate/array"

  included do
    has_ancestry

    def name_for_selects
      "#{'|' if depth > 0}" + "#{'---' * depth} #{nome}"
    end

    def name_for_tree
      "<span class='tree_#{depth}'>#{nome}</span>".html_safe
    end

    def possible_parents
      parents = self.class.arrange_as_array#(:order => 'name')
      return new_record? ? parents : parents - subtree
    end
  end

  module ClassMethods
    def arrange_as_array(options={}, hash=nil)
      hash ||= arrange(options) unless hash.is_a? Array

      arr = []

      hash.each do |node, children|
        arr << node
        arr += arrange_as_array(options, children) unless children.nil?
      end
      arr
    end
  end

end
