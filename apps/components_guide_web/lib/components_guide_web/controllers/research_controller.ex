defmodule ComponentsGuideWeb.ResearchController do
  use ComponentsGuideWeb, :controller
  use Phoenix.HTML

  alias ComponentsGuide.Research.Spec

  def index(conn, %{"q" => query}) do
    query = query |> String.trim()

    case query do
      "" ->
        render(conn, "empty.html")

      query ->
        results = load_results(query)
        render(conn, "index.html", %{query: query, results: results})
    end
  end

  def index(conn, _params) do
    index(conn, %{"q" => ""})
  end

  defp h2(text) do
    content_tag(:h2, text, class: "font-bold")
  end

  defp load_results(query) when is_binary(query) do
    # Spec.clear_search_cache()
    [
      content_tag(:article, [
        h2("HTML spec"),
        Spec.search_for(:whatwg_html_spec, query)
      ]),
      content_tag(:article, [
        h2("Can I Use"),
        Spec.search_for(:caniuse, query)
      ])
    ]
  end
end
