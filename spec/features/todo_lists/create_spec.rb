require 'spec_helper'

describe "Creating todo lists" do
  def create_todo_list(options={})
    options[:title] ||= "My Todo list" #default value if not sent in
    options[:description] ||= "This is what im doin"

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")
    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Create Todo list"

  end



  it "redirects to the todo list index page on success" do
    create_todo_list
    expect(page).to have_content("My Todo list")
  end

  it "displays error when the todo list has no title" do
    expect(TodoList.count).to eq(0)

    create_todo_list title: "", description: "This is what im doin"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("This is what im doin")

  end

  it "displays error when the todo list has a title less than 3 characters" do
    expect(TodoList.count).to eq(0)

    create_todo_list title: "Hi"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("This is what im doin")

  end

  it "displays error when the todo list has no description" do
    expect(TodoList.count).to eq(0)

    create_todo_list description: ""

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("This is what im doin")

  end

  it "displays error when the todo list has a title less than 3 characters" do
    expect(TodoList.count).to eq(0)

    create_todo_list description: "Derp"


    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("This is what im doin")

  end
end
