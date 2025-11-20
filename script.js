document.addEventListener("DOMContentLoaded", function () {
  const categorySelectId = "00NWC000004Mh7F";
  const typeSelectId = "00NWC000004MfyH";

  const categorySelect = document.getElementById(categorySelectId);
  const typeSelect = document.getElementById(typeSelectId);

  // ----- Single Click Toggle: CATEGORY -----
  categorySelect.addEventListener("mousedown", function (e) {
    e.preventDefault();
    const option = e.target;
    if (option.tagName === "OPTION") {
      option.selected = !option.selected;
      categorySelect.dispatchEvent(new Event("change"));
    }
  });

  // ----- Single Click Toggle: SERVICE TYPE -----
  typeSelect.addEventListener("mousedown", function (e) {
    e.preventDefault();
    const option = e.target;
    if (option.tagName === "OPTION") {
      option.selected = !option.selected;
      typeSelect.dispatchEvent(new Event("change"));
    }
  });

  const serviceOptions = {
    "Bearing Repack": [
      { val: "Tandem Axle", text: "Tandem Axle" },
      { val: "Triple Axle", text: "Triple Axle" },
    ],
    "Suspension Upgrade": [
      { val: "Roadmaster Comfort Ride", text: "Roadmaster Comfort Ride" },
      {
        val: "Lippert Center-Point Air Ride System",
        text: "Lippert Center-Point Air Ride",
      },
      { val: "CRE 3000 (MORyde)", text: "CRE 3000 (MORryde)" },
      { val: "AllTrek 4000 (MORryde)", text: "AllTrek 4000 (MORryde)" },
      {
        val: "Heavy Duty Shackle and Wet Bolt Kit (MORryde)",
        text: "Heavy Duty Shackle & Wet Bolt Kit",
      },
      { val: "Crossmember (MORryde)", text: "Crossmember (MORryde)" },
      { val: "Unsure", text: "Unsure / Need Advice" },
    ],
    "Disc Brake Upgrade": [
      { val: "DeeMaxx", text: "DeeMaxx" },
      { val: "Kodiak", text: "Kodiak" },
      { val: "Disc Brake Upgrade - Unsure", text: "Unsure / Need Advice" },
    ],
    "Additional Safety Products": [
      { val: "Hubsavers", text: "Hubsavers" },
      { val: "Solid Steel Lugnuts", text: "Solid Steel Lugnuts" },
    ],
  };

  if (categorySelect && typeSelect) {
    categorySelect.addEventListener("change", function () {
      updateServiceTypes(categorySelect, typeSelect, serviceOptions);
    });
  }

  function updateServiceTypes(catSelect, typSelect, optionsMap) {
    const selectedOptions = Array.from(catSelect.selectedOptions);

    // Save current type selections
    const prevSelected = new Set(
      Array.from(typSelect.selectedOptions).map((opt) => opt.value)
    );

    typSelect.innerHTML = "";
    let hasValidSelections = false;

    if (selectedOptions.length > 0) {
      selectedOptions.forEach((option) => {
        const categoryName = option.value;

        if (optionsMap[categoryName]) {
          hasValidSelections = true;

          const group = document.createElement("optgroup");
          group.label = categoryName;

          optionsMap[categoryName].forEach((opt) => {
            const newOption = document.createElement("option");
            newOption.value = opt.val;
            newOption.text = opt.text;

            // Restore previous selection if still valid
            if (prevSelected.has(opt.val)) {
              newOption.selected = true;
            }

            group.appendChild(newOption);
          });

          typSelect.appendChild(group);
        }
      });
    }

    if (hasValidSelections) {
      typSelect.disabled = false;
    } else {
      typSelect.disabled = true;
      const defaultOption = document.createElement("option");
      defaultOption.text =
        selectedOptions.length === 0
          ? "-- Select Categories First --"
          : "No subtypes for selection";
      typSelect.appendChild(defaultOption);
    }
  }
});
