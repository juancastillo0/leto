import ExecutionEnvironment from "@docusaurus/ExecutionEnvironment";

if (ExecutionEnvironment.canUseDOM) {
  // Ctrl + K should focus the search bar, emulating the Algolia search UI
  document.onkeydown = function (e) {
    const cancelButton = document.querySelector(".aa-DetachedCancelButton");
    if ((e.ctrlKey || e.metaKey) && e.key == "k") {
      if (cancelButton) {
        cancelButton.click();
      } else {
        const searchButton = document.querySelector(".aa-DetachedSearchButton");
        if (searchButton) {
          searchButton.click();
        }
      }

      // By default, using Ctrl + K in Chrome will open the location bar, so disable this
      e.preventDefault();
    } else if (e.key === "Escape" && cancelButton) {
      cancelButton.click();
    }
  };
}
