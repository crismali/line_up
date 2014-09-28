require "spec_helper"

class Product < ActiveRecord::Base
end

RSpec.describe LineUp do
  it "is a module" do
    expect(subject).to be_a(Module)
  end

  describe "#line_up!" do
    let(:products) { 3.times.map { Product.create! } }
    let(:ordered_ids) { products.map(&:id).reverse }

    context "arguments" do
      it "uses the position column by default" do
        Product.line_up!(ordered_ids)
        expect(Product.pluck(:position).compact).to be_present
        expect(Product.pluck(:other_position).compact).to be_blank
      end

      it "uses the specified column if provided" do
        Product.line_up!(ordered_ids, :other_position)
        expect(Product.pluck(:position).compact).to be_blank
        expect(Product.pluck(:other_position).compact).to be_present
      end

      it "raises an error if the specified column doesn't exist" do
        column_name = "position = 2; delete from products where id = #{products.first.id}; select * from products"
        expect do
          Product.line_up!(ordered_ids, column_name)
        end.to raise_error(LineUp::UndefinedColumnError, "a column named '#{column_name}' does not exist on the products table")
      end
    end

    context "ordering" do
      let!(:product) { Product.create! position: 55 }

      before do
        Product.line_up!(ordered_ids)
      end

      it "orders the records based on their index in the id array" do
        ids = Product.where(id: ordered_ids).order(:position).pluck(:id)
        expect(ids).to eq(ordered_ids)
      end

      it "only reorders the specified records" do
        product.reload
        expect(product.position).to eq(55)
      end
    end

    context "constraints" do
      it "does not update each record individually" do
        expect_any_instance_of(Product).to_not receive(:update_attributes)
        Product.line_up!(ordered_ids)
      end

      it "sql escapes the ids" do
        Product.line_up!(["2;delete from products where id = #{products.first.id}"])
        expect(Product.count).to eq(3)
      end
    end
  end
end
